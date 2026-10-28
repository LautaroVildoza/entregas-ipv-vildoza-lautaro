extends AbstractStateMachine
 
## Esta máquina de estados deriva los eventos que le llegan (señales de
## la escena) al estado activo, para que solo reaccione el estado que
## corresponde y no ejecute código de estados inactivos.
 
 
func notify_body_entered(body: Node) -> void:
	_forward_event(&"body_entered", body)
 
 
func notify_body_exited(body: Node) -> void:
	_forward_event(&"body_exited", body)
 
 
func notify_hit(amount: int) -> void:
	_forward_event(&"hit", amount)
 
 
# Se mantiene el nombre original del callback para no romper la conexión
# de señal guardada en la escena (las conexiones se guardan por nombre).
func _on_Turret_hp_changed(hp: int, max_hp: int) -> void:
	_forward_event(&"hp_changed", [hp, max_hp])
 
 
# Idem: se mantiene el nombre original por la conexión de la escena.
func _on_Body_animation_finished() -> void:
	_on_animation_finished(character.get_current_animation())
 
 
# Si el evento llega antes de que la máquina termine de inicializarse
# (por ejemplo, un body_entered apenas se instancia la torreta),
# todavía no hay estado activo: se ignora en vez de crashear.
func _forward_event(event: StringName, value = null) -> void:
	if current_state == null:
		return
	current_state.handle_event(event, value)
