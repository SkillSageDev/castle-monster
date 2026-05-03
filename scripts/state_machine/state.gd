extends Node

class_name State

signal Transitioned

func Enter():
	pass

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass




# You Will Inherit you're states from this code

# to change state ex: from idle to walk then: in idle code Transitioned.emit(self,walk)