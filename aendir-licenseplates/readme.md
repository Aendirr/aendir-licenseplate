

# Gerekli olanlar
- QBCore
- qb-inventory/lj-inventory
- oxmysql

------------------------------------------------------------------------------------

* Görseller dosyasındaki görselleri qb-inventory html görsellerinize ekleyin
* Alttaki satırı bu dosya yoluna ekleyin: qb-core>shared>item.lua 
```lua
	['licenseplate'] 				 = {['name'] = 'licenseplate', 			  	  	['label'] = 'License Plate', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'licenseplate.png', 			['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
```

* qb inventory >server > main.lua'ya gidin, 1550-1579 satırları civarında, satırlar envanterinize göre değişebilir, aşağıdaki parçayı arayabilirsiniz
```lua
	elseif itemData["name"] == "markedbills" then
		info.worth = math.random(5000, 10000)
```
* Aşağıdaki parçayı aşağıya veya yukarıya yapıştırın fark etmez
```lua
	elseif itemData["name"] == "licenseplate" then
		info.plate = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(2))
```
* Html > js > app.js'ye gidin ve aşağıdaki satırları bulun
```lua
	} else if (itemData.name == "driver_license") {
		$(".item-info-title").html("<p>" + itemData.label + "</p>");
		$(".item-info-description").html(
			"<p><strong>First Name: </strong><span>" +
			itemData.info.firstname +
			"</span></p><p><strong>Last Name: </strong><span>" +
			itemData.info.lastname +
			"</span></p><p><strong>Birth Date: </strong><span>" +
			itemData.info.birthdate +
			"</span></p><p><strong>Licenses: </strong><span>" +
			itemData.info.type +
			"</span></p><p style=\"font-size:11px\"><b>Weight: </b>" + itemData.weight + " | <b>Amount: </b> " + itemData.amount + " | <b>Quality: </b> " + "<a style=\"font-size:11px;color:green\">" + Math.floor(itemData.info.quality) + "</a>"
		);
```
* Ve altına şunu yapıştırın
```lua
	} else if (itemData.name == "licenseplate") {
		$(".item-info-title").html('<p>' + itemData.label + '</p>')
		$(".item-info-description").html('<p><strong>Plate Number: </strong><span>'+ itemData.info.plate);
```
