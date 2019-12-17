//
//  CriadorDeLeilao.swift
//  Leilao
//
//  Created by Felipe Weber on 17/12/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class CriadorDeLeilao: NSObject {

    private  var leilao:Leilao!
    
    func para(descricao: String) -> Self{
        leilao = Leilao(descricao: descricao)
        return self
    }
    
    func lance(_ usuario: Usuario, _ valor: Double) -> Self{
        leilao.propoe(lance: Lance(usuario, valor))
        return self
    }
    
    func constroi() -> Leilao{
        return leilao
    }
}
