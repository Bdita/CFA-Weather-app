require './progressbar'
require 'paint'
require 'terminal-table'

class Questioner
  def initialize(questions, days)
    @questions = questions
    @days = days
  end
  attr_accessor :questions, :days

  def ask(progress_bar)
    rows = []

    @questions.zip(@days).each do |question, day|
      system("clear")
      puts "#{progress_bar.title}: #{progress_bar.current_step}"
      puts question
      answer = gets.chomp.to_i
      temp_faren = (answer * 1.8 + 32).round #celsius to farenheit

      if answer > 30
        answer = Paint[answer, :red]
        temp_faren = Paint[temp_faren, :red]
      else
        answer = Paint[answer, :blue]
        temp_faren = Paint[temp_faren, :blue]
      end
      rows << [day, answer, temp_faren]
    #accessing another class progress_bar object and its current step
    #..(cont)method whose value is 1 and adds 1 to it during each iteration of loop.
      progress_bar.current_step = progress_bar.current_step + 1
    end

    if progress_bar.current_step == @questions.length + 1
      system("clear")
      puts "Thank you for answering my questions, you answered with:"
    end

    table = Terminal::Table.new :title => "Bandita Temp Chart", :headings => ['Name', 'Celsius', 'Farenheit'], :rows => rows
    puts table
    end
end

days_list = [
  "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
]
question_list = [
  "What's the temperature on  Monday on Celsius?",
  "What's the temperature on Tuesday on Celsius?",
  "What's the temperature on Wednesday on Celsius?",
  "What's the temperature on Thursday on Celsius?",
  "What's the temperature on Friday on Celsius?",
  "What's the temperature on Saturday on Celsius?",
  "What's the temperature on Sunday on Celsius?",
]

my_questioner = Questioner.new(question_list, days_list)
progress_bar = ProgressBar.new("Day")

my_questioner.ask(progress_bar)
