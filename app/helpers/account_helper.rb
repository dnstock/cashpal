module AccountHelper
  
  def get_months_options
    start_month = Date.civil(2007,7,1)
    last_month = Date.today
    #.year * 100 + Date.today.month
    
    
    @months = []
    i = last_month.year
    j = last_month.month
    counter = i * 100 + j
    endloop = start_month.year * 100 + start_month.month
    while counter >= endloop

      if j < 10 then
        @months << [ get_month_name(j) + " " + i.to_s,i.to_s + "0" + j.to_s  ]        
      else
        @months << [ get_month_name(j) + " " + i.to_s,i.to_s +  j.to_s  ]        
      end
      j = j - 1
      if j < 1 then 
        j = 12
        i = i - 1
      end
      counter = i * 100 + j
    end
    
    return @months
  end
  
  def get_month_name(i)
    monthnames = [nil] + %w(January February March April May June July August September October November December)  
    return monthnames[i]
  end
  
  def show_current_user
    usr = Array.new
    usr << @current_user.login
    usr << @current_user.last_login_at
    usr << @current_user.email
    usr << @current_user.payment_email
    usr << @current_user.created_at
    usr.inspect
    #@current_user.to_yaml
#    @current_user.each_pair do |key, value|
#      print "#{key} = #{value}"
#    end
  end

end