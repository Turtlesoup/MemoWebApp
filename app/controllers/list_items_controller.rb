class ListItemsController < ApplicationController
  def new
    @listitem = ListItem.new
  end
  
  def create
    @listitem = ListItem.new(list_item_params)
    @listitems = ListItem.all
    
    respond_to do |format|
      if @listitem.save
        format.html { render "sessions/index" }
        format.js { render :action => "create", :layout => false}
        #render :partial => 'list_items/listContainer', :object => @listitems
      else
        format.html { render "session/index" }
      end
    end
  end
  
  def list_item_params
    params.require(:list_item).permit(:label)
  end
  
  def destroy
    ListItem.find(params[:id]).destroy
    @listitems = ListItem.all
    
    #respond_to do |format|
    #  format.html { render "sessions/index", confirm: 'Are you sure?', method: :delete }
    #  format.js { render :action => "destroy" }
    #end
    
    redirect_to logged_in_path
    
    #render :partial => 'list_items/listContainer', :layout => false, :object => @listitems
  end
end
