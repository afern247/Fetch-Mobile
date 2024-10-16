//
//  Illustration.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import Foundation

/*
 
 How to add new Illustration
 
 - The name of the file must begein with `illustration.`
 - On Assets, add 1 of the 2 files (light/dark mode if you require it for multi-theme) and on the image settings, on Appearance, select `Any Dark`. Make sure to place the light mode image on the light and the dark one below on the dark.
 
 */

/// Illustrations available in the Illustration Library.
public enum Illustration: String, CaseIterable {
    case spinnerImage
}
