class EventTag < ActiveRecord::Base
	# Hade inte behövt detta objekt med tanke på hur applikationen ser ut i dagsläget,
	#  men det kan behövas senare därför implemneterar jag det på en gång
	#  
	belongs_to :event
	belongs_to :tag
end