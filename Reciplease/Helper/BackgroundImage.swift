//
//  BackgroundImage.swift
//  Reciplease
//
//  Created by laz on 04/01/2023.
//

import SwiftUI

struct BackgroundImage: View {
    var height: CGFloat
    
    var src: URL?
    var data: Data?
    
    var body: some View {
        ZStack {
            if let data = data {
                Image(uiImage: UIImage(data: data)!)
                    .backgroundStyle(height: height)
            } else {
                AsyncImage(url: src) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            Image("default")
                                .backgroundStyle(height: height)
                            ProgressView()
                                .progressViewStyle(.circular)
                        }
                    case .success(let image):
                        image
                            .backgroundStyle(height: height)
                    default:
                        Image("default")
                            .backgroundStyle(height: height)
                    }
                }
            }
            Constant.gradient
                .frame(maxHeight: height)
        }
    }
}

struct BackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImage(height: Constant.rowHeight, src: URL(string: "https://edamam-product-images.s3.amazonaws.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEKf%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIQC8DDCUR6iIrTlKE1Xkn15MbTHKW4neK9rfbtHfOvN%2BVgIgPIXgFsNhCUtEKPBLS0IoA%2FFazXpGzsuoVP7GTnOfrEwq1QQI7%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARAAGgwxODcwMTcxNTA5ODYiDIYYkajZ2sO4Agb3BSqpBN1LAwzU9Az%2FkRHFbqcUE%2FYqU1jvYPaLow9aqPZboFyJbS0Lj8kBnnxUtmoTPSADnkDhBjo5BD4f0DdA4%2BofI0fyRQaOhLoJLzBoYbKSV4oTchEhIANKMsBefMQNw4oJpjsL%2FXMul0gkmSVME71ItU4BJdTOpMN7pgJoAJ7L11aN1OKJ24tqICDxc5PCRPiJb604okRRmyxER%2BGyCjUCrXmEo%2BlAFwy6gpY7ZN1TCxeWVarDLqkfuCAgO3GZSSe6%2FXyAcPj5ZGeuZ1t0mYdPf7RKlLwuXXZWY8sg43krqRehKP08DQWQM05O%2FVUHzDRtso%2FoK%2B2yAjFxp%2FvY%2FMchyiCD32NRp7nHR51s%2Fgc34eNtEFt0lq8fKQtxRzMcxL0dB7DRRLSaOA5%2BM2a5kS1dp4hmwqU3OJ85%2FNicZ3wPigw0%2Fizg12l5lCJ0r%2FwiL3Gkz8gaUNn8fiaRnJpA8jn5xrbYMs1Ly7jTNZzfVReWVoCsEAR4Cv%2FlP%2B9gFdNTKcq46%2BaN%2FMOxUNlCL02kBFZ9jPPE63ZwSFNZiiTcoAqGBriwfVTxRTLVy8VZ2IIGGZHDsollGw0V6%2Bhmt3VKo1wDUruEXtKqNPgD83bSDXHm1jG%2BvwR3OdRVs%2FUhbXT7PE5oAHc1fQrp9uPIgKFjlR6dLmrQxdesM7b55mEJpLPBdcqhQ8XXZEAYufes53ep7A7ZnPj3NBPSh9xLBh2TTHICiHMoY4VJGEc6N7AwwpbWnQY6qQHN67RonwB%2FJCHrR%2FUvCPKtqjrgjO81uAUclPI%2FkmsLTxDJOYAKIQcrjhXEtLhpTZhomxIFAgU12mvtXLHqVW37RLgH0jStdOmgL%2B0X1y7WVLpKjWjuyCxeIAZHjBWaA03QFI104ZYg0NZT7Z5qPQQq1SobymIO5E0m%2B80hUtjj%2FOVKHVeGf8HGmcJ5UAnWe7kIeZsis95sC8w8ipVcruULAyfLgs17gwq%2F&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230104T152157Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFBC6HDZWK%2F20230104%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=8e7a034a7ed9b1730cacbf02707e3f6675601030c23eaef79ae3244cce164efd"))
    }
}
