class LikeController < ApplicationController
  unloadable
  before_action :global_authorize

  # Display the totals of likes 
  def index
    @like_count_for_issue = {}
    @like_count_for_journal = {}
    @like_count_for_wiki = {}
    @like_count_total = {}
    
    # Counting for each user
    @users = User.where(type: "User").where(status: 1)
    @users.each do |user|
      issue_count = Like.where(user_id: user.id).where(like_type: 'issue').length
      journal_count = Like.where(user_id: user.id).where(like_type: 'journal').length
      wiki_count = Like.where(user_id: user.id).where(like_type: 'wiki').length

      @like_count_for_issue[user.id] = issue_count
      @like_count_for_journal[user.id] = journal_count
      @like_count_for_wiki[user.id] = wiki_count
      @like_count_total[user.id] = issue_count + journal_count + wiki_count
    end
  end

  # Update number of likes
  def update_like
        # Get post value
        like_id = params[:like_id]
        like_type = params[:like_type]

        # Referer
        referer = request.env['HTTP_REFERER']

        # Get like
        like = Like.where(like_id: like_id).where(like_type: like_type)
        count = like.length
        own_like = like.where(user_id: User.current.id)
        own_count = own_like.length

        if own_count == 0 then
          # Add
          new_like = Like.new(user_id: User.current.id, like_id: like_id, like_type: like_type)
          new_like.save!
          # Get user to send
          case like_type
            when 'issue' then
              kind = I18n.t(:label_issue)
              issue = Issue.find(like_id)
              user_to = User.find(issue.author_id)
            when 'journal' then
              kind = I18n.t(:field_notes)
              journal = Journal.find(like_id)
              user_to = User.find(journal.user_id)
            when 'wiki' then
              kind = I18n.t(:label_wiki)
              wiki_content = WikiPage.find(like_id).content
              user_to = User.find(wiki_content.author_id)
            else
              # nothing to do
          end
          # Send a mail
          if LikeConstants::ENABLE_MAIL_NOTIFICATION == 1 && defined? kind
            title = I18n.t(:like_mail_title, :name => User.current.lastname, :kind => kind)
            content = referer.to_s
            LikeMailer.on_like(user_to, title, content).deliver
          end
          count = count + 1
        else
          # Remove
          own_like.delete_all
          count = count - 1
        end

        # Return json
        result_hash = {}
        result_hash["result"] = count
        render json: result_hash
  end

  def global_authorize
    @current_user ||= User.current
    render_403 unless @current_user.type == 'User'
  end
end
