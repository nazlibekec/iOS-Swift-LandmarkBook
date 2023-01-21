//
//  ViewController.swift
//  LandmarkBook
//
//  Created by Nazlı on 16.01.2023.
//

import UIKit



// UITableViewDelegate, UITableViewDataSource bu iki protokolü tanımlamazsak tableView ı kullanamayız. Bu ikisinin fonksiyonunu da class içerisinde tanımlamamız gerekiyor.
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    
    var landmarkNames = [String]()
    var lanmarkImages = [UIImage] ()
    
    var chosenLandmarkName = "" //seçilmiş row
    var chosenLandmarkImage = UIImage() //seçilmiş row
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Protokollerin yetkisini ViewControllera veriyoruz.
        tableView.delegate = self
        tableView.dataSource = self
        
        
        // var landmarkNames = [String]() yukarı tanımladık her yerde kullanabilmek için
        landmarkNames.append("Galata Kulesi")
        landmarkNames.append("İstiklal Caddesi")
        landmarkNames.append("İstanbul Boğazı")
        landmarkNames.append("Kız Kalesi")
        landmarkNames.append("Ortaköy Cami")
        
        
        // var lanmarkImages = [UIImage] () yukarı tanımladık her yerde kullanabilmek için
        lanmarkImages.append(UIImage(named: "galataKulesi")!)
        lanmarkImages.append(UIImage(named: "istiklalCaddesi")!)
        lanmarkImages.append(UIImage(named: "bogaz")!)
        lanmarkImages.append(UIImage(named: "kızKalesi")!)
        lanmarkImages.append(UIImage(named: "ortakoy")!)
        
        
    }
    
    
    //Yukarıda tanımlanan protokollerle ilişkili.
    //numberOfRowsInSection : kaç tane göstereceği
    //cellForRowAt : ne göstereceği
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarkNames.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //cell.textLabel?.text = "test" //Artık kullanılmıyor.
        var content = cell.defaultContentConfiguration()
        content.text = landmarkNames[indexPath.row]  //isimleri sırasına göre getir.
        // content.image = lanmarkImages[indexPath.row]  resimler büyük olduğu için çirkin oldu.
        content.secondaryText = "Resmi görmek için tıkla"
        cell.contentConfiguration = content
        return cell
        
    }

    //Bir hücre seçildiğinde ne yapılacağını gösteren fonksiyon
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenLandmarkName = landmarkNames[indexPath.row] //seçilen rowu eşitle
        chosenLandmarkImage = lanmarkImages[indexPath.row] //seçilen rowu eşitle
        performSegue(withIdentifier: "toDetailsVC", sender: nil) //her bir hücreye tıklanınca segue yapıp diğer ekrana geçiyor.
        
    }
    
    //prepare diye arat.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsVC
            // destinationVC yani gidilecek VC DetailsVC olarak tanımlanır. ! eminim demek.
           //Bu sayede DetailsVC de tanımlanan değişkenlere erişebiliriz.
            
            //seçilenleri eşitledik.
            destinationVC.selectedLandmarkName = chosenLandmarkName
            destinationVC.selectedLandmarkImage = chosenLandmarkImage
            
        }
    }
    //Sola kaydırınca silme işlemi.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.landmarkNames.remove(at: indexPath.row)
            self.lanmarkImages.remove(at: indexPath.row)
            // tableView.reloadData() tamamını tekrar oluşturacağı için çok verilerde kullanışlı değil.
            tableView.deleteRows(at: [indexPath], with: .fade) //animasyonlu silecek. Fakat uygulama tekrar açılınca veriler yeniden gelecek. Çünkü kod baştan çalışacağı için her açılışta yukardaki dizileri oluşturacak.
            
        }
    }
    
}

