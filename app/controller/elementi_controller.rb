class ElementiController < ApplicationController

def create
  @ordine = current_ordine
  @prodotto = elemento_params[:prodotto_id]
  @taglia = elemento_params[:taglia]

  @elemento = @ordine.elementi.find_by(prodotto_id: @prodotto, taglia: @taglia)

  if @elemento 
    @ordine = current_ordine
    @ordine.elementi.each {|elemento| elemento.quantita += 1 }
    @elemento.update_attributes(elemento_params)
    @elementi = @ordine.elementi
  else
    @elemento = @ordine.elementi.new(elemento_params)
  end

  @ordine.save
  session[:ordine_id] = @ordine.id
end

  def update
    @ordine = current_ordine
    @elemento = @ordine.elementi.find(params[:id])
    @elemento.update_attributes(elemento_params)
    @elementi = @ordine.elementi
  end

  def destroy
    @ordine = current_ordine
    @no_elementi = current_ordine_destroy
    @elemento = @ordine.elementi.find(params[:id])
    @elemento.destroy
    @elementi = @ordine.elementi
  end
private

  def elemento_params
    params.require(:elemento).permit(:taglia, :quantita, :prodotto_id, :ordine_id)
  end
end
