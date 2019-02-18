require 'io/console'
require_relative "definicion"
class Interfaz
  include Definicion
  def initialize
    @i=0
    @preguntas = Preguntas.new
  end
  def menu()
    begin
      clearConsole()
      puts 'Digita "reglas" para saber como jugar, "play" para comenzar'
      puts 'y "new" para agregar una nueva pregunta'
      action = gets.chomp.to_s

      case action
      when "reglas"
        rules()
      when "play"
        play()
      when "new"
        newQuestion()
      end
    rescue SignalException => e
      puts "Volver al menu? y/n"
      respuesta = gets.chomp.to_s
      if respuesta == "y"
        menu()
      else
        puts "vuelve pronto"
      end      
    end
  end
  def play()
    clearConsole()
    while @i < (@preguntas.definiciones.length - 1)
      code = @i+1
      @preguntas.preguntar(code)
      respuesta = gets.chomp.to_s
      clearConsole()
      @i += 1  if @preguntas.respuesta(code,respuesta)
    end
    puts "---¡Ganaste!---"
  end
  def newQuestion()
    clearConsole()
    puts "Ingresa la definicion:"
    definicion = gets.chomp.to_s
    puts "Ingresa la respuesta:"
    respuesta = gets.chomp.to_s
    @preguntas.agregar(definicion,respuesta)
    menu()
  end
  def rules()
    clearConsole()
    puts "Jugar es muy simple, en pantalla aparecera una definicion"
    puts "y deberás adivinar a que palabra corresponde ese significado"
    puts "Ejemplo:"
    @preguntas.preguntar("0")
    ans = gets.chomp.to_s
   
    if @preguntas.respuesta("0",ans)
      clearConsole()
      puts("Exelente! estas listo para jugar, preciona alguna letra para continuar")
      STDIN.getch
      menu()
    else
       rules()
    end

  end
  def clearConsole()
    if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
       system('cls')
     else
       system('clear')
    end
 end
end
interfaz = Interfaz.new
interfaz.menu()
