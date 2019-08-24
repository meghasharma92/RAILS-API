module SerializableResource
	def parse_json(object)
		ActiveModelSerializers::SerializableResource.new(object)
	end
end