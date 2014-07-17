module Caboose
  class MediaController < ApplicationController
    layout 'caboose/admin'
    # GET /admin/media/photos
    def photos_index
      return unless user_is_allowed 'pages','view'
      @gen = Pager.new(params, {},{
        'model' => 'Caboose::Photo',
        'sort'  => 'id',
        'desc'  => 'true',
        'base_url' => '/admin/media/photos',
        'use_url_params' => 'false'
      })
      @images = @gen.items
    end

    def photos_new
      return unless user_is_allowed('pages','edit')
    end

    def photos_create
      return unless user_is_allowed('pages', 'edit')
      
      resp = StdClass.new({
        'error' => nil,
        'redirect' => nil
      })

      photo = Photo.new
      photo.image = params[:image]
      photo.name = params[:name].blank? ? photo.image_file_name : params[:name]
      
      if photo.save
        resp.redirect = "/admin/media/photos"
      else
        resp.error = photo.errors.first
      end

      render json: resp
    end

  end
end
