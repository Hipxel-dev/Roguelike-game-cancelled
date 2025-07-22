extends Control

var time = 60

var seconds = 0
var minutes = 0
var hours = 0

func _physics_process(delta: float) -> void:
	
	if gamesystem.settings.settings[22][1]:
		show()
		time += delta
		
		if time > 0:
			seconds = int(time) % 60
			minutes = int(floor(time / 60)) % 60
			hours = int(floor(time / 3600)) % 24
		
		var hourtext = "00"
		var mintext = "00"
		
		for i in range(str(hours).length()):
			hourtext[i] = str(hours)[i]
		for i in range(str(minutes).length()):
			mintext[i] = str(minutes)[i]
		
		var hourtextarr = []
		var mintextarr = []
		for i in range(hourtext.length()):
			hourtextarr.append(hourtext[i])
		for i in range(mintext.length()):
			mintextarr.append(mintext[i])
		
		hourtextarr.invert()
		mintextarr.invert()
		
		for i in range(hourtextarr.size()):
			hourtext[i] = hourtextarr[i]
		for i in range(mintextarr.size()):
			mintext[i] = mintextarr[i]
		
		$text.text = str(hourtext," : ",mintext," : ",seconds)
	else:
		hide()
