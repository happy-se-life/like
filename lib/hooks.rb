module LikeHooks
  class Hooks < Redmine::Hook::ViewListener
    # Like icon on issue
    def view_issues_show_details_bottom(context={})
      like = Like.where(like_id: context[:issue].id).where(like_type: 'issue')
      like_count = like.length
      like_sender_ids = like.pluck(:user_id)
      like_senders = User.where(id: like_sender_ids)
      icon_design = LikeConstants::ICON_DESIGN
      context[:controller].send(:render_to_string, {
        :partial => "issues/issuesShowDetailsBottom",
        :locals => { id: context[:issue].id, count: like_count, type: 'issue', design: icon_design, like_senders: like_senders}
      })
    end
    # Like icon on Journal
    def view_issues_history_journal_bottom(context={})
          if context[:journal].notes.blank? then
            # Resolved an issue with duplicate icons in version 4.1
            return
          end
          like = Like.where(like_id: context[:journal].id).where(like_type: 'journal')
          like_count = like.length
          like_sender_ids = like.pluck(:user_id)
          like_senders = User.where(id: like_sender_ids)
          icon_design = LikeConstants::ICON_DESIGN
          context[:controller].send(:render_to_string, {
            :partial => "issues/issuesHistoryJournalBottom",
            :locals => { id: context[:journal].id, count: like_count, type: 'journal', design: icon_design, like_senders: like_senders}
          })
    end
    # Like icon on Wiki
    def view_layouts_base_content(context={})
      request = context[:request]
      if context[:controller].controller_name == 'wiki' && context[:controller].action_name == 'show' then
        wiki_title = URI.decode(request.path.split("/").last)
        str = URI.decode(request.path.split("/projects/").last)
        identifier = str.split("/wiki/").first
        wiki_pages = WikiPage.where(title: wiki_title)
        for wiki_page in wiki_pages do
          if wiki_page.project.identifier == identifier then
            wiki = wiki_page
            break
          else
            wiki = nil
          end
        end
        if wiki != nil then
          wiki_id = wiki.id
          like = Like.where(like_id: wiki_id).where(like_type: 'wiki')
          like_count = like.length
          like_sender_ids = like.pluck(:user_id)
          like_senders = User.where(id: like_sender_ids)
          is_wiki = true
        else
          wiki_id = 0
          like_count = 0
          is_wiki = false
        end
      else
        wiki_id = 0
        like_count = 0
        is_wiki = false
      end
      icon_design = LikeConstants::ICON_DESIGN
      context[:controller].send(:render_to_string, {
        :partial => "wiki/layoutsBaseContent",
        :locals => { id: wiki_id, count: like_count, type: 'wiki', is_wiki: is_wiki, design: icon_design, like_senders: like_senders}
      })
    end
  end
end