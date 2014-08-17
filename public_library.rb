class Library

	def initialize(*shelves)
			@shelves = shelves
			puts "Library successfully created."
	end

	def add_shelf(shelf)
		@shelves << shelf
		puts "You have added shelf #{shelf.id} to the library."
	end

	def remove_shelf(shelf)
		if shelf.books.empty?
			@shelves.delete(shelf)
			puts "You have removed shelf #{shelf.id} from the library."
		else
			puts "Sorry, this shelf is not empty."
		end
	end

	def books
		@shelves.each do |shelf|
			shelf.books.each do |book|
				puts "#{book.title} by #{book.author} is on shelf #{shelf.id}."
			end
		end
	end

end

class Shelf
	attr_accessor :books
	attr_reader :id

	def initialize(id, *books)
		@id = id
		@books = books
		@books.each { |book| book.shelf = self }
		puts "Shelf #{@id} successfully created."
	end

	def list_books
		if @books.empty?
			puts "Shelf #{@id} is empty."
			return
		end
		puts "Shelf #{@id} contains:"
		@books.each do |book|
			puts "#{book.title} by #{book.author}"
		end
	end

end

class Book
	attr_reader :author
	attr_reader :title
	attr_accessor :shelf

	def initialize(author, title)
		@author = author
		@title = title
		puts "#{@title} by #{@author} is now in the library."
	end

	def enshelf(shelf)
		# only shelve the book if it's currently unshelved
		unless @shelf
			@shelf = shelf
			@shelf.books << self
			puts "You have put #{@title} by #{@author} on shelf #{@shelf.id}."
		else
			puts "You must unshelve the book before trying to put it on another shelf."
		end
	end

	def unshelf
		# only unshelve the book if it's currently shelved
		if @shelf
			@shelf.books.delete(self)
			@shelf = nil
			puts "You have taken #{@title} by #{@author} off the shelf."
		else
			puts "Sorry, the book is already off the shelf."
		end
	end

end

puts " Creating an empty library ".center(50, '*')
puts "\n"
lib = Library.new
puts "\n"
puts " Creating and labeling some shelves ".center(50, '*')
puts "\n"
shelf1, shelf2, shelf3 = Shelf.new("22A"), Shelf.new("14R"), Shelf.new("7F")
lib.add_shelf(shelf1)
lib.add_shelf(shelf2)
lib.add_shelf(shelf3)
puts "\n"
puts " Adding favorite books to the library ".center(50, '*')
puts "\n"
book1, book2, book3 = Book.new("Al Burian", "The Burn Collector"), Book.new("Richard Dawkins", "The God Delusion"), Book.new("Dave Eggers", "We Shall Know Our Velocity")
book4, book5, book6 = Book.new("Stephen Hawking", "A Brief History of Time"), Book.new("Stephen Weinberg", "Dreams of a Final Theory"), Book.new("Carl Sagan", "Pale Blue Dot")
puts "\n"
puts " Stocking the shelves ".center(50, '*')
puts "\n"
book1.enshelf(shelf1)
book2.enshelf(shelf1)
book3.enshelf(shelf2)
book4.enshelf(shelf2)
book5.enshelf(shelf3)
book6.enshelf(shelf3)
puts "\n"
puts " Adding an empty shelf to the library ".center(50, '*')
puts "\n"
shelf4 = Shelf.new("32D")
lib.add_shelf(shelf4)
puts "\n"
puts " Removing an empty shelf ".center(50, '*')
puts "\n"
lib.remove_shelf(shelf4)
puts "\n"
puts " Trying to remove a non-empty shelf ".center(50, '*')
puts "\n"
lib.remove_shelf(shelf3)
puts "\n"
puts " Listing all the books in the library ".center(50, '*')
puts "\n"
lib.books
puts "\n"
puts " Listing all books on a shelf ".center(50, '*')
puts "\n"
shelf2.list_books
puts "\n"
puts " Trying to shelve an already-shelved book ".center(50, '*')
puts "\n"
book3.enshelf(shelf3)
puts "\n"
puts " Unshelving a book ".center(50, '*')
puts "\n"
book4.unshelf
puts "\n"
puts " Trying to unshelve an already-unshelved book ".center(50, '*')
puts "\n"
book4.unshelf
puts "\n"
puts " Reshelving a book ".center(50, '*')
puts "\n"
book4.enshelf(shelf1)