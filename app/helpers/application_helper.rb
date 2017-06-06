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
    
    def title
       if controller_name == 'home'
          case action_name 
           when 'index'
               return t('site.title.root')
           when 'product'
               return t('site.title.product') + @product.name
           when 'register_exposition'
               return t('site.title.register_exposition')
           when 'category'
               return t('site.title.category') + @category.name
           when 'following'
               return t('site.title.following') 
           when 'favorites'
               return t('site.title.favorites')     
               
          end
          
          elsif controller_name == 'tickets'
              case action_name 
              when 'index'
                  return t('site.title.tickets')
              when 'new'
                  return t('site.title.new_ticket')
               when 'conversation'
                  return t('site.title.conversation')
              end
          elsif controller_name == 'exposition'
          case action_name 
              when 'show'
               return t('site.title.exposition_show') + ' ' + @exposition.exposition_name 
                  
          end
              
          elsif controller_name == 'users'
          case action_name 
            when 'sign_in'
              return t('site.title.sign_in')
            when 'sign_up'
              return t('site.title.sign_up')
             
       end
       
        return t('site.title.root')
    end

end
