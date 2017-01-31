class ProfileSerializer < ActiveModel::Serializer
  attributes :name, :description

  def name
    object.name
  end
end
