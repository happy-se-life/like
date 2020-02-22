module LikeHooks
  class Hooks < Redmine::Hook::ViewListener
    # Like icon on issue
    def view_issues_show_details_bottom(context={})
      like_count = Like.where(like_id: context[:issue].id).where(like_type: 'issue').length
      icon_design = LikeConstants::ICON_DESIGN
      context[:controller].send(:render_to_string, {
        :partial => "issues/issuesShowDetailsBottom",
        :locals => { id: context[:issue].id, count: like_count, type: 'issue', design: icon_design}
      })
    end
    # Like icon on Journal
    def view_issues_history_journal_bottom(context={})
          like_count = Like.where(like_id: context[:journal].id).where(like_type: 'journal').length
          icon_design = LikeConstants::ICON_DESIGN
          context[:controller].send(:render_to_string, {
            :partial => "issues/issuesHistoryJournalBottom",
            :locals => { id: context[:journal].id, count: like_count, type: 'journal', design: icon_design}
          })
    end
    # Like icon on Wiki
    def view_layouts_base_content(context={})
      request = context[:request]
      if context[:controller].controller_name == 'wiki' && context[:controller].action_name == 'show' then
        wiki_title = URI.decode(request.path.split("/").last)
        wiki = WikiPage.find_by(title: wiki_title)
        if wiki != nil then
          wiki_id = wiki.id
          like_count = Like.where(like_id: wiki_id).where(like_type: 'wiki').length
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
        :locals => { id: wiki_id, count: like_count, type: 'wiki', is_wiki: is_wiki, design: icon_design}
      })
    end
  end
end