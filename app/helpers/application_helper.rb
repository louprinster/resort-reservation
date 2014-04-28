module ApplicationHelper

  def num_of_days_helper(start_date, end_date)
    if start_date == end_date
      num_of_days = 1
    else  
      num_of_days = (start_date...end_date).count
    end
    num_of_days
  end
  

  def rate_helper(rental_type, date)

    if (date.strftime("%u").to_i == 5) || (date.strftime("%u").to_i == 6) 
      rate = rental_type.weekend_rate
    else
      rate = rental_type.weekday_rate
    end

  end

  def pluralize_helper(num, word)
    if num > 0
      "#{num} #{word.pluralize(num)}".html_safe
    end
  end

end  # module
