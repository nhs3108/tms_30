require "active_support/time"


(2015..2025).each do |year|
  (1..12).each do |month|
    every "0 6 " + Time.days_in_month(month, year).to_s + " #{month} #{year}" do
      runner "Course.send_all_courses_info"
    end
  end
end

every :day, at: "6:00am" do
  runner "Course.notify_will_be_expired"
end

every :day, at: "11:00pm" do
  runner "User.send_trainees_report"
end
