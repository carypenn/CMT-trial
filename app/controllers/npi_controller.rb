class NpiController < ApplicationController
  def index
    @records = NpiRecord.all
    respond_to do |format|
      format.html
      format.json  { render json: @records }
    end
  end

  def show
    npi = NpiService.getNpiRecord(params[:id])
    unless npi.nil?
      if x = NpiRecord.where(number: npi.number).first
        x.destroy
      end
      npi.save
    end
    respond_to do |format|
      format.html { redirect_to action: 'index' }
      format.json  { render json: NpiRecord.all }
    end
  end
end
