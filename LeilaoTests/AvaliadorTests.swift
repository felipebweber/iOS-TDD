//
//  AvaliadorTests.swift
//  LeilaoTests
//
//  Created by Felipe Weber on 17/12/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import XCTest
@testable import Leilao

class AvaliadorTests: XCTestCase {
    var leiloeiro:Avaliador!
    private var joao:Usuario!
    private var maria:Usuario!
    private var jose:Usuario!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        joao = Usuario(nome: "Joao")
        jose = Usuario(nome: "Jose")
        maria = Usuario(nome: "Maria")
        
        leiloeiro = Avaliador()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDeveEntenderLancesEmOrdemCrescente(){
        // Cenario
        
        
        let leilao = Leilao(descricao: "Playstation 4")
        leilao.propoe(lance: Lance(maria, 250.0))
        leilao.propoe(lance: Lance(joao, 300.0))
        leilao.propoe(lance: Lance(jose, 400.0))
        
        // Acao
        
        
        try? leiloeiro.avalia(leilao: leilao)
        
        // Validacao
        
        XCTAssertEqual(250.0, leiloeiro.menorLance())
        XCTAssertEqual(400.0, leiloeiro.maiorLance())
    }
    
    func testDeveEntenderLeilaoComApenasUmLance(){
        
        let leilao = Leilao(descricao: "Xbox One")
        leilao.propoe(lance: Lance(joao, 2000.0))
        
        try? leiloeiro.avalia(leilao: leilao)
        
        //Avaliacao
        XCTAssertEqual(2000.0, leiloeiro.menorLance())
        XCTAssertEqual(2000.0, leiloeiro.maiorLance())
    }
    
    func testDeveEncontrarOsTresMaioresLances(){
        
//        let leilao = Leilao(descricao: "Xbox One")
//        leilao.propoe(lance: Lance(joao, 1000.0))
//        leilao.propoe(lance: Lance(maria, 1100.0))
//
//        leilao.propoe(lance: Lance(joao, 2000.0))
//        leilao.propoe(lance: Lance(maria, 2002.0))
        
        let leilao = CriadorDeLeilao().para(descricao: "Xbox One")
            .lance(joao, 1000.0)
            .lance(maria, 1100.0)
            .lance(joao, 2000.0)
            .lance(maria, 2002.0).constroi()
        
        try? leiloeiro.avalia(leilao: leilao)
        
        let listaLances = leiloeiro.tresMaiores()
        
        XCTAssertEqual(3, listaLances.count)
        XCTAssertEqual(2002.0, listaLances.first?.valor)
        XCTAssertEqual(2000.0, listaLances[1].valor)
        XCTAssertEqual(1100.0, listaLances[2].valor)
    }
    
    func testDeveIgnorarLeilaoSemNenhumLance(){
        let leilao = CriadorDeLeilao().para(descricao: "Cafeteira expresso").constroi()
//        XCTAssertThrowsError(try leiloeiro.avalia(leilao: leilao), "Não é possível avaliar leilão sem lances, {(error)})
        XCTAssertThrowsError(try leiloeiro.avalia(leilao: leilao), "Não é possível avaliar leilão sem lances") { (error) in
            print(error.localizedDescription)
        }
    }

}
