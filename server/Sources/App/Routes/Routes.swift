import Foundation
import Vapor

extension Droplet {
    func setupRoutes() throws {
        get("user") { req in
            guard let acceptHeader = req.headers["Accept"],
                let acceptType = AcceptType(rawValue: acceptHeader) else {
                return try! NetworkError.with {
                    $0.code = NetworkError.Code.badRequest
                    $0.message = "bad request"
                }.jsonUTF8Data()
            }

            return UserResponse.with {
                $0.users = [
                    User.with {
                        $0.name = "Takeshi Ihara"
                        $0.gender = Gender.male
                    },
                    User.with {
                        $0.name = "Hanako Yamada"
                        $0.gender = Gender.female
                    }
                ]
            }.encodeData(with: acceptType)
        }

        post("user") { req in
            guard let acceptHeader = req.headers["Accept"],
                let acceptType = AcceptType(rawValue: acceptHeader) else {
                return try! NetworkError.with {
                    $0.code = NetworkError.Code.badRequest
                    $0.message = "bad request"
                }.jsonUTF8Data()
            }

            guard let bytes = req.body.bytes else {
                return try! NetworkError.with {
                    $0.code = NetworkError.Code.badRequest
                    $0.message = "bad request"
                }.jsonUTF8Data()
            }

            do {
                let request = try UserRequest(serializedData: Data(bytes: bytes))
                return UserResponse.with {
                    $0.users = [
                        User.with {
                            $0.name = "Takeshi Ihara"
                            $0.gender = Gender.male
                        },
                        User.with {
                            $0.name = "Hanako Yamada"
                            $0.gender = Gender.female
                        },
                        User.with {
                            $0.name = request.name
                            $0.gender = request.gender
                        }
                    ]
                }.encodeData(with: acceptType)
            } catch {
                return try! NetworkError.with {
                    $0.code = NetworkError.Code.badRequest
                    $0.message = "bad request"
                }.jsonUTF8Data()
            }
        }
    }
}
