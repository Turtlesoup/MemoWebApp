class ListItemsController < ApplicationController
  def new
    @listitem = ListItem.new
  end
  
  def create
    @listitem = ListItem.new(list_item_params)
    
    itemsWithSameLabel = ListItem.find_by(user: current_user.id, label: @listitem.label)
    if !itemsWithSameLabel
      #create and save a new list item
      @listitem.user = current_user.id
      @listitem.index = ListItem.where(user: current_user.id).length
      
      if @listitem.save
        @listitem = ListItem.new
        @listitems = ListItem.where(user: current_user.id).order(:index)
        redirect_to logged_in_path
      else
        @listitem = ListItem.new
        @listitems = ListItem.where(user: current_user.id).order(:index)
        redirect_to logged_in_path
      end
    else
      #item already exists with same label
      @listitem = ListItem.new
      @listitems = ListItem.where(user: current_user.id).order(:index)
      redirect_to logged_in_path
    end
  end
  
  def list_item_params
    params.require(:list_item).permit(:label,:user,:index)
  end
  
  def destroy
    #get the list item to remove
    listItemToRemove = ListItem.find(params[:id])
    
    #for all items with an index greater than that of the item being removed,
    #we want to decrease its index accordingly in order to maintain the ordering
    #of the list items
    listItemToRemoveIndex = listItemToRemove.index
    listitems = ListItem.where(user: current_user.id)
    for listItem in listitems
      if listItem.index > listItemToRemoveIndex
        listItem.index -= 1
        listItem.save
      end
    end
    
    #destroy the item
    listItemToRemove.destroy
    
    #update the list items value with the remaining list items
    @listitems = ListItem.where(user: current_user.id).order(:index)
    
    redirect_to logged_in_path
    
    #render :partial => 'list_items/listContainer', :layout => false, :object => @listitems
  end
end
