require "csv"
class WinesController < ApplicationController
    layout :choose_layout
    private def choose_layout
        if action_name == "index"
            "wineswimage"
        else
            "wines"
        end
    end

    def index
    end
    def disp
        @wines = Wine.alphabet
    end
    def disp2
        @wines = Wine.couleur
        render("wines/disp")
    end
    def disp3
        @wines = Wine.millesime
        render("wines/disp")
    end
    def disp4
        @wines = Wine.regions
        render("wines/disp")
    end
    def disp5
        @wines = Wine.cepage
        render("wines/disp")
    end

    def csv
        csv_path = Rails.root.join("public/cellar_saintismier.csv")
        Wine.delete_all
        CSV.foreach(csv_path) do |line|
            obj = Wine.new
            obj.nom = line[0]
            obj.couleur = line[1]
            obj.producteur = line[2]
            obj.cru = line[3]
            obj.millesime = line[4]
            obj.regions = line[5]
            obj.cepage = line[6]
            obj.qte = line[7]
            obj.estimation = line[8]
            obj.save
        end
        @wines = Wine.alphabet
    end

    def new
        lname=session[:lname]
        if not lname
            session[:backafterreg] = winesclean_path
            redirect_to login_path
        end
    end

    def add
        obj = Wine.new
        obj.nom = params[:nom]
        obj.couleur = params[:couleur]
        obj.producteur = params[:producteur]
        obj.cru = params[:cru]
        obj.millesime = params[:millesime]
        obj.regions = params[:regions]
        obj.cepage = params[:cepage]
        obj.qte = params[:qte]
        obj.estimation = params[:estimation]
        obj.evaluation = params[:evaluation]
        obj.save
        redirect_to wines_path
    end

    def clean
        lname=session[:lname]
        if not lname
            session[:backafterreg] = "/wines"
            redirect_to login_path
            return
        end
        @wines = Wine.alphabet
    end

    def del
        wid = params[:wid]
        Wine.destroy(wid)
        @wines = Wine.alphabet
        render("wines/clean")
    end

    def qte
        lname=session[:lname]
        if not lname
            session[:backafterreg] = "/wines"
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
        render("wines/qte")
    end

    def updmax
        wine_id = params[:wid]
        wine = Wine.find_by(id: wine_id)
        if wine
            wine.increment!(:qte)
            wine.save
        end
        @wines = Wine.alphabet
        render("wines/qte")
    end
end
