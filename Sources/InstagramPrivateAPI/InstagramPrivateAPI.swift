//
//  InstagramPrivateAPI.swift
//  InstagramPrivateAPI
//
//  Copyright (c) 2021 Changbeom Ahn
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

public struct User: Codable {
    public var pk: Int
    public var username: String
    public var full_name: String
    public var is_private: Bool
    public var profile_pic_url: String
}

public struct Caption: Codable {
    public var pk: String
    public var user_id: Int
    public var text: String
    public var type: Int
    public var content_type: String
    public var user: User
    public var is_covered: Bool
    public var media_id: String
}

public struct ImageVersions2: Codable {
    public struct Candidate: Codable {
        public var width: Int
        public var height: Int
        public var url: String
    }
    
    public var candidates: [Candidate]
    
    public struct AdditionalCandidates: Codable {
        public var igtv_first_frame: Candidate
        public var first_frame: Candidate
    }
    
    public var additional_candidates: AdditionalCandidates?
}

public struct CarouselMedia: Codable {
    public var id: String
    public var media_type: Int
    public var image_versions2: ImageVersions2?
    public var original_width: Int
    public var original_height: Int
    public var video_versions: [VideoVersions]?
}

public struct VideoVersions: Codable {
    public var type: Int
    public var width: Int
    public var height: Int
    public var url: String
    public var id: String
}

public struct MediaCroppingInfo: Codable {
    public struct SquareCrop: Codable {
        public var crop_left: Double
        public var crop_right: Double
        public var crop_top: Double
        public var crop_bottom: Double
    }
    
    public var square_crop: SquareCrop
}

public struct Post: Codable {
    public var taken_at: Int
    public var id: String
    public var media_type: Int
    public var carousel_media_count: Int?
    public var carousel_media: [CarouselMedia]?
    public var user: User
    public var image_versions2: ImageVersions2?
    public var original_width: Int?
    public var original_height: Int?
    public var video_codec: String?
    public var video_versions: [VideoVersions]?
    public var caption: Caption?
    public var product_type: String
//    var media_cropping_info: MediaCroppingInfo?
    public var is_seen: Bool
    public var is_eof: Bool
}

public struct IgResponseError: Codable {
    public var stack: String
    public var message: String
    public var name: String
    
    public struct Response: Codable {
        public var statusCode: Int
        // ...
    }
    
    public var response: Response
    public var text: String
}

public struct CallBackInfo: Codable {
    public var type: String
    public var login: User?
    public var timeline: [Post]?
    public var loadNext: [Post]?
    // ...
    public var error: IgResponseError?
}

public enum MediaType: Int, CustomStringConvertible {
    case image    = 0b0001
    case video    = 0b0010
    case carousel = 0b1000
    
    public var description: String {
        switch self {
        case .image:
            return "image"
        case .video:
            return "video"
        case .carousel:
            return "carousel"
        }
    }
}

extension Post: CustomStringConvertible {
    public var description: String {
        "\(user.username): \(mediaType!) \(carouselDescription ?? "")"
    }
    
    public var mediaType: MediaType? { MediaType(rawValue: media_type) }
    
    var carouselDescription: String? {
        carousel_media?.map { MediaType(rawValue: $0.media_type)!.description }.joined(separator: ", ")
    }
}

public extension CarouselMedia {
    var mediaType: MediaType? { MediaType(rawValue: media_type) }
}
