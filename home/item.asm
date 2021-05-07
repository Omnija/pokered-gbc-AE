; uses an item
; UseItem is used with dummy items to perform certain other functions as well
; INPUT:
; [wcf91] = item ID
; OUTPUT:
; [wActionResultOrTookBattleTurn] = success
; 00: unsuccessful
; 01: successful
; 02: not able to be used right now, no extra menu displayed (only certain items use this)
UseItem::
	jpba UseItem_

; confirms the item toss and then tosses the item
; INPUT:
; hl = address of inventory (either wNumBagItems or wNumBoxItems)
; [wcf91] = item ID
; [wWhichPokemon] = index of item within inventory
; [wItemQuantity] = quantity to toss
; OUTPUT:
; clears carry flag if the item is tossed, sets carry flag if not
TossItem::
	ld a, [H_LOADEDROMBANK]
	push af
	ld a, BANK(TossItem_)
	ld [H_LOADEDROMBANK], a
	ld [MBC1RomBank], a
	call TossItem_
	pop de
	ld a, d
	ld [H_LOADEDROMBANK], a
	ld [MBC1RomBank], a
	ret

; checks if an item is a key item
; INPUT:
; [wcf91] = item ID
; OUTPUT:
; [wIsKeyItem] = result
; 00: item is not key item
; 01: item is key item
IsKeyItem::
	push hl
	push de
	push bc
	callba IsKeyItem_
	pop bc
	pop de
	pop hl
	ret
	