
class Parser
	module TemplateHelpers
		extend ActiveSupport::Concern

		def update_contents_parser_class!
      class_name = name.gsub(/\s/, '_').camelize
      self.content = content.gsub(/^class .* </, "class #{class_name} <")
      self.message = 'Renamed parser class'
      self.save
	  end

	  def apply_parser_template!
	  	if self.content.nil?

	  		parser_template = []
	  		parser_template << "class #{self.name.gsub(/\s/, "_").camelize} < SupplejackCommon::#{self.strategy.capitalize}::Base"

	  		if parser_template_name.present?
	  			template = ParserTemplate.find_by_name(parser_template_name)
	  			parser_template << "\t" + template.content.gsub(/\n/, "\n\t")
	  		end

	  		parser_template << "end"

	  		self.content = parser_template.join("\n\n")
	  		self.message = "Applied parser template."
	  	end
	  end
	end
end
