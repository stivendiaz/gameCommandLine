require 'json/add/core'
module Definicion
  class Preguntas
    attr_reader :definiciones
    def initialize
      @definiciones= []
      cargar()
    end

    def cargar()
      if existe?()
        @definiciones = eval(File.read('preguntas.json'))
      else
        puts "archivo de preguntas no encontrado, se creara un nuevo archivo"
        puts "y deberas crear preguntas para jugar \n"
        File.write("preguntas.json", {}.to_json)
      end
    end

    def preguntar(id)
      puts @definiciones[id.to_s.to_sym]["def".to_sym]
    end

    def respuesta(id, respuesta)
     if @definiciones[id.to_s.to_sym]["res".to_sym].to_s.downcase == respuesta.to_s.downcase
       puts "¡Correcto!"
       return true
     else
       puts "Incorrecto, intenta nuevamente!"
       return false
     end
    end

    def existe?()
      (File.file?("preguntas.json")) ? true : false
    end

    def agregar(definicion, respuesta)
      id = (@definiciones.length -1) + 1
      @definiciones[id.to_s.to_sym] = { def: definicion, res: respuesta}
      File.write("preguntas.json", @definiciones.to_json)
    end

  end
end
