module ApplicationHelper
    def toast(text,time=3000,classes=['blue'])
       return false if text.nil?
       objects="
       $(document).ready(function(){
       Materialize.toast('#{text}',#{time},'#{classes.join(' ')}');
       })
       "
       content_tag(:script, raw(objects))

    end
end
