# TODO file a bug with Mongoid and then trash this patch

module Formtastic
  class SemanticFormBuilder
    def generate_association_input_name(method) #:nodoc:
      if reflection = self.reflection_for(method)
        if [:references_many].include?(reflection)
          "#{method.to_s.singularize}_ids"
        else
          "#{method}_id"
        end
      else
        method
      end.to_sym
    end
    
    def association_macro_for_method(method) #:nodoc:
      reflection = self.reflection_for(method)
      reflection = :belongs_to if reflection == :referenced_in
    end
  end
end