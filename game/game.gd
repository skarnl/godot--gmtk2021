extends Node2D


var target_config


onready var target = $Target
onready var suspects = $Suspects


func _ready():
#	get target configuration
	target_config = target.get_configuration()

#   generate variaties (3 bijv) en assign die aan paar suspects
	suspects.set_target_configuration(target_config)


#   genereer dan de overige suspects

#   wanneer erop geklikt, selecteer en hou bij welke geklikt zijn
#   bereken elke keer het eindresultaat

#   toon het eindresultaat direct

#    -> dit wordt later pas gedaan ON CLICK van de process-knop
	pass
