module ApplicationHelper
    def toast(text,time=3000,classes=['blue'])
       return false if text.nil?
       objects="
       document.addEventListener('turbolinks:load', function() {
       Materialize.toast('#{text}',#{time},'#{classes.join(' ')}');
       })
       "
       content_tag(:script, raw(objects))
    end
    
    def gravatar_for(user, options = { size: 180,classes: 'circle responsive-img'})
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        size = options[:size]
        classes = options[:classes]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.name, class: classes)
    end

end
