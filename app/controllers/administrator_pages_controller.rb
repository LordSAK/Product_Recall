class AdministratorPagesController < ApplicationController
  def ChangeFeatures
  end

  def Recalls
  	@categories = Recall.select("DISTINCT(Category)")
  	@recall = Recall.all
  end

  def ShiftSubscriber
  end
end
