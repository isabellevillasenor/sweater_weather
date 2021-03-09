class TrailSerializer
  include FastJsonapi::ObjectSerializer
  set_id {nil}
  attributes :trail, :forecast
end