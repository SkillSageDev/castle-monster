class_name State

extends Node

signal transitioned

func enter():
	pass


func exit():
	pass


func update(_delta: float):
	pass


func physics_update(_delta: float):
	pass




# You Will Inherit you're states from this code

# to change state ex: from idle to walk then: in idle code transitioned.emit(self,walk)
