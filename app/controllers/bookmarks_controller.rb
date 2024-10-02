class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :update, :destroy]

  def index
    @bookmarks = Bookmark.all
    render json: @bookmarks, each_serializer: BookmarkSerializer
  end

  def show
    render json: @bookmark, serializer: BookmarkSerializer
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)

    if @bookmark.save
      render json: @bookmark, serializer: BookmarkSerializer, status: :created
    else
      render json: @bookmark.errors, status: :unprocessable_entity
    end
  end

  def update
    if @bookmark.update(bookmark_params)
      render json: @bookmark, serializer: BookmarkSerializer
    else
      render json: @bookmark.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy
    head :no_content
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.permit(:name)
  end
end
