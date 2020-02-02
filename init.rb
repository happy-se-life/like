Redmine::Plugin.register :like do
  name 'Like plugin'
  author 'Kohei Nomura'
  description 'This plug-in allows you to send the likes.'
  version '0.0.1'
  url 'https://twitter.com/happy_se_life'
  author_url 'mailto:kohei_nom@yahoo.co.jp'
  require_dependency 'hooks'
  menu :application_menu, :like, { :controller => 'like', :action => 'index' }, :caption => 'LIKE!', :if => Proc.new { User.current.logged? }
end