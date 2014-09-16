class TraysController < ApplicationController
  # GET /trays/1
  # GET /trays/1.json
  def show
    @tray = Tray.find params[:id]

    respond_to do |format|
      format.html
      format.pdf
    end
  end

  # POST /trays
  # POST /trays.json
  def create
    @base_unit = BaseUnit.find params[:base_unit_id]
    @tray = @base_unit.trays.create(tray_params)
    redirect_to @base_unit, notice: 'Tray was successfully added.'
  end

  # GET /trays/1/edit
  def edit
    @tray = Tray.find params[:id]
  end

  # PATCH/PUT /trays/1
  # PATCH/PUT /trays/1.json
  def update
    @tray = Tray.find params[:id]

    respond_to do |format|
      if @tray.update(tray_params)
        format.html { redirect_to @tray.base_unit, notice: 'Tray was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /trays/1
  # DELETE /trays/1.json
  def destroy
    @tray = Tray.find params[:id]
    @base_unit = @tray.base_unit
    @tray.destroy
    respond_to do |format|
      format.html { redirect_to @base_unit, notice: 'Tray was destroyed.' }
      format.json { head :no_content }
    end
  end

private
  # Never trust parameters from the scary internet, only allow the white list through.
  def tray_params
    params.require(:tray).permit(:files, :ranks, :gap_percent)
  end
end
