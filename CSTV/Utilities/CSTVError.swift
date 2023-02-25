//
//  CSTVError.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import Foundation

enum CSTVError: String, Error {
    
    case unableToComplete = "Não foi possível concluir a solicitação. Por favor, verifique sua conexão à internet."
    case invalidResponse = "Resposta inválida do servidor. Por favor, tente novamente."
    case invalidData = "Os dados recebidos do servidor eram inválidos. Por favor, tente novamente."
}
