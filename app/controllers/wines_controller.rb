require 'csv'
class WinesController < ApplicationController
  layout :choose_layout

  def index; end

  def disp
    @wines = Wine.alphabet
  end

  def disp2
    @wines = Wine.couleur
    render('wines/disp')
  end

  def disp3
    @wines = Wine.millesime
    render('wines/disp')
  end

  def disp4
    @wines = Wine.regions
    render('wines/disp')
  end

  def disp5
    @wines = Wine.cepage
    render('wines/disp')
  end

  def list
    @wines = Wine.alphabet
    @lines = [' --- Liste des vins pour inventaire ---']
    @wines.each do |wine|
      @lines.append("#{wine.nom} --- #{wine.millesime} --- #{wine.qte}")
    end
  end

  def csv
    csv_path = Rails.root.join('cellar_saintismier.csv')
    puts "*** csvpath : #{csv_path}"
    Wine.delete_all
    CSV.foreach(csv_path) do |line|
      obj = Wine.new
      updatefromcsv(obj, line)
      obj.save
    end
    @wines = Wine.alphabet
  end

  def new
    lname = session[:lname]
    unless lname
      session[:backafterreg] = '/wines/new'
      redirect_to login_path
      return
    end
    @wine = Wine.new
  end

  def create
    puts "Params received: #{params.inspect}"
    @wine = Wine.new(wine_params)
    @wine.save
    redirect_to '/wines/new'
  end

  def show
    @wine = Wine.find(params[:id])
  end

  def mod
    lname = session[:lname]
    unless lname
      session[:backafterreg] = '/wines'
      redirect_to login_path
      return
    end
    @wines = Wine.alphabet
  end

  def edit
    @wine = Wine.find(params[:id])
  end

  def update
    @wine = Wine.find(params[:id])
    if @wine.update(wine_params)
      redirect_to @wine, notice: 'Wines was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @wine = Wine.find(params[:id])
    puts "*** destroy wine #{@wine.id}"
    @wine.destroy
    @wines = Wine.alphabet
    redirect_to '/winesmod'
  end

  def qte
    lname = session[:lname]
    unless lname
      session[:backafterreg] = '/wines'
      redirect_to login_path
      return
    end
    @wines = Wine.alphabet
  end

  def updmin
    wine_id = params[:wid]
    wine = Wine.find_by(id: wine_id)
    if wine
      wine.decrement!(:qte)
      wine.save
    end
    @wines = Wine.alphabet
    render('wines/qte')
  end

  def updmax
    wine_id = params[:wid]
    wine = Wine.find_by(id: wine_id)
    if wine
      wine.increment!(:qte)
      wine.save
    end
    @wines = Wine.alphabet
    render('wines/qte')
  end

  private

  def choose_layout
    case action_name
    when 'index'
      'wineswimage'
    when 'list'
      'winesblank'
    else
      'wines'
    end
  end

  def wine_params
    params.require(:wine).permit(
      :nom,
      :couleur,
      :producteur,
      :cru,
      :millesime,
      :regions,
      :cepage,
      :qte,
      :estimation,
      :evaluation
    )
  end

  def updatefromcsv(obj, line)
    obj.nom = line[0]
    obj.couleur = line[1]
    obj.producteur = line[2]
    obj.cru = line[3]
    obj.millesime = line[4]
    obj.regions = line[5]
    obj.cepage = line[6]
    obj.qte = line[7]
    obj.estimation = line[8]
  end
end
