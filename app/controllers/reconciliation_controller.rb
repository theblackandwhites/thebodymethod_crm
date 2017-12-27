class ReconciliationController < ApplicationController
  require 'date'

  def reconcile
    @charges = Charge.where("created_at > ?", Date.today).order('created_at DESC').all
    @charge_days = @charges.group_by { |b| b.created_at.beginning_of_day}
  end

  def reconcile_bookable
  	@bookable = Bookable.find(params[:key])
  	@bookable.update_attributes(reconciled: true)
  	redirect_to reconcile_path

  end

end


# At the moment i'm looping throuh all booklables.

# But I want to also show the charges that occure outside of a booking. 
#These are all online payments such as debt payments, packages etc that aren't attached to a bookable.