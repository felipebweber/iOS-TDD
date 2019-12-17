//
//  AvaliadorTests.swift
//  LeilaoTests
//
//  Created by Felipe Weber on 17/12/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import XCTest
@testable import Leilao

class LeilaoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDeveReceberUmLance(){
        let leilao = Leilao(descricao: "Ipad pro 10.5")
        XCTAssertEqual(0, leilao.lances?.count)
        
        let steveJobs = Usuario(nome: "Steve Jobs")
        leilao.propoe(lance: Lance(steveJobs, 2500.0))
        
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(2500.0, leilao.lances?.first?.valor)
    }
    
    func testDeveReceberVariosLances(){
        let leilao = Leilao(descricao: "Macbook Pro 13")
        
        let steveJobs = Usuario(nome: "Steve Jobs")
        leilao.propoe(lance: Lance(steveJobs, 2000.0))
        
        let billGates = Usuario(nome: "Bill Gates")
        leilao.propoe(lance: Lance(billGates, 2200.0))
        
        XCTAssertEqual(2, leilao.lances?.count)
        
        XCTAssertEqual(2000.0, leilao.lances?.first?.valor)
        XCTAssertEqual(2200.0, leilao.lances?[1].valor)
    }
    
    func testDeveIgnorarDoisLancesSeguidosDoMesmoUsuario(){
        let leilao = Leilao(descricao: "Macbook Pro 13")
        
        let steveJobs = Usuario(nome: "Steve Jobs")
        leilao.propoe(lance: Lance(steveJobs, 2000.0))
        leilao.propoe(lance: Lance(steveJobs, 2400.0))
        
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(2000.0, leilao.lances?.first?.valor)
    }
    
    func testDeveIgnorarMaisQue5LancesDoMesmoUsuario(){
        let leilao = Leilao(descricao: "iPhone XS 256GB")
        
        let steveJobs = Usuario(nome: "Steve Jobs")
        let billGates = Usuario(nome: "Bill Gates")
        
        leilao.propoe(lance: Lance(steveJobs, 2000.0))
        leilao.propoe(lance: Lance(billGates, 2200.0))
        
        leilao.propoe(lance: Lance(steveJobs, 3000.0))
        leilao.propoe(lance: Lance(billGates, 3200.0))
        
        leilao.propoe(lance: Lance(steveJobs, 4000.0))
        leilao.propoe(lance: Lance(billGates, 4200.0))
        
        leilao.propoe(lance: Lance(steveJobs, 5000.0))
        leilao.propoe(lance: Lance(billGates, 5200.0))
        
        leilao.propoe(lance: Lance(steveJobs, 6000.0))
        leilao.propoe(lance: Lance(billGates, 6200.0))
        
        //Deve ignorar
        leilao.propoe(lance: Lance(steveJobs, 7000.0))
        
        XCTAssertEqual(10, leilao.lances?.count)
        XCTAssertEqual(6200.0, leilao.lances?.last?.valor)
    }
    
}
