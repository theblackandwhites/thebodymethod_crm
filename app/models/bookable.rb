class Bookable < ApplicationRecord
  belongs_to :bookable_type
  belongs_to :location
  belongs_to :instructor
  has_many :participants
  has_many :charges

  serialize :recurring, Hash

  def recurring=(value)
  	if RecurringSelect.is_valid_rule?(value)
  		super(RecurringSelect.dirty_hash_to_rule(value).to_hash)
  	else
  		super(nil)
  	end
  end

  def rule
  	IceCube::Rule.from_hash recurring
  end

  def schedule(start) 
  	schedule = IceCube::Schedule.new
  	schedule.add_recurrence_rule(rule)
  	schedule
  end

  def calendar_bookables
  	if recurring.empty? 
  	    [self]
    else
        start_date = Date.today
        end_date = Date.today + 30.days
        schedule(start_time).occurrences(end_date).each do |date|
            @book = Bookable.new(
              date_start: date,
             	time_start: time_start,
             	time_start_unit: time_start_unit,
             	time_finish: time_finish,
             	time_finish_unit: time_finish_unit,
             	bookable_type_id: bookable_type_id,
             	location_id: location_id,
             	instructor_id: instructor_id,
             	price: price,
             	pay_cash: pay_cash,
             	pay_online: pay_online,
             	pay_points: pay_points,
             	attendee_count: attendee_count,
             	reconciled: reconciled,
             	start_time: date
             	)
            @book.save!


        end
    end
  end

end
