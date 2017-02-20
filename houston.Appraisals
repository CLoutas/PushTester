##
# HOUSTON
# ---------
#
# Houston is a simple gem for sending Apple Push Notifications. Pass your credentials, construct your message, and send it.
# https://github.com/nomad/houston
##

require 'houston'

# Environment variables are automatically read, or can be overridden by any specified options. You can also
# conveniently use `Houston::Client.development` or `Houston::Client.production`.
APN = Houston::Client.development
APN.certificate = File.read("apple_push_notification_SwiftingNotification.pem")

# An example of the token sent back when a device registers for notifications
token = "<44e5cb71a62f802e6e1cddc63a83815938195c29612fb3c44552aa18db5fea5b>"

# Create a notification that alerts a message to the user, plays a sound, and sets the badge on the app
notification = Houston::Notification.new(device: token)
notification.alert = {
    title: "SampleTitle",
    body: "SampleBody"
}

# Notifications can also change the badge count, have a custom sound, have a category identifier, indicate available Newsstand content, or pass along arbitrary data.
notification.badge = 57
notification.sound = "sosumi.aiff"
# notification.category = "INVITE_CATEGORY"
notification.content_available = true
# notification.mutable_content = true
notification.custom_data = { foo: "bar" }

# And... sent! That's all it takes.
APN.push(notification)
