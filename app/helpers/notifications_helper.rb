module NotificationsHelper
  
  def notification_form(notification)
  @comment=nil
  visitor=link_to notification.visitor.name, notification.visitor, style:"font-weight: bold;"
  your_post=link_to 'Your Post', notification.post, style:"font-weight: bold;", remote: true
  case notification.action
    when "follow" then
      "#{visitor}is following you"
    when "like" then
      "#{visitor}liked #{your_post}"
    when "comment" then
      @comment=Comment.find_by(id:notification.comment_id)&.content
      "#{visitor} commented #{your_post}"
  end
  end
end