class Api::V1::PortalV1Controller < ApplicationController

  def hello
    render json: success_response("hello")
  end

  def get_ideas
    ideas = Idea.order(:created_at)
    resp = {
      items: ideas,
      count: ideas.size
    }
    render json: success_response(resp)
  end

  def create_idea
    description = params.require(:description)
    color = params.require(:color)
    Idea.create!(
      description: description,
      color: color,
      position: {
        x: 0,
        y: 0
      }
    )
    render json: success_response("OK")
  end

  def update_idea
    description = params.require(:description)
    bucket_id = params["bucket_id"]
    idea_id = params.require(:idea_id)
    i = Idea.find_by(id: idea_id)
    if i.nil?
      raise BaseError::BadRequest.new("404 - Idea Not Found")
    end
    i.update!(
      description: description,
      bucket_id: bucket_id
    )
    render json: success_response("OK")
  end

  def update_idea_pos
    idea_id = params.require(:idea_id)
    pos = params.require(:pos)
    i = Idea.find_by(id: idea_id)
    if i.nil?
      raise BaseError::BadRequest.new("404 - Idea Not Found")
    end
    i.update(position: pos)
    render json: success_response("OK")
  end

  def remove_idea
    idea_id = params.require(:idea_id)
    i = Idea.find_by(id: idea_id)
    if i.nil?
      raise BaseError::BadRequest.new("404 - Idea Not Found")
    end
    i.destroy!
    render json: success_response("OK")
  end

  def get_buckets
    b = Bucket.order(:created_at)
    c = []
    b.each do |v|
      d = v.attributes
      d["ideas"] = v.ideas
      c.push(d)
    end
    resp = {
      items: c,
      count: c.size
    }
    render json: success_response(resp)
  end

  def create_bucket
    t = params.require(:title)
    Bucket.create!(
      title: t
    )
    render json: success_response("OK")
  end

  def update_bucket
    bucket_id = params.require(:bucket_id)
    title = params.require(:title)
    b = Bucket.find_by(id: bucket_id)
    if b.nil?
      raise BaseError::BadRequest.new("404 - Bucket Not found")
    end
    b.update!(title: title)
    render json: success_response("OK")
  end

  def remove_bucket
    bucket_id = params.require(:bucket_id)
    b = Bucket.find_by(id: bucket_id)
    if b.nil?
      raise BaseError::BadRequest.new("404 - Bucket Not found")
    end
    render json: success_response("OK")
  end



end
