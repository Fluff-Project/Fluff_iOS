# Fluff_iOS



### Commit Message

- [Update], [Create], [Delete] 시작 메세지는 이렇게
- 메세지를 ViewController의 '스크롤링 기능 구현'





### Code Convention

* 서로 파일 만들 때, 직관적으로 알아볼 수 있는지 물어보기
* ViewController 같은 경우 ==> ~~VC
* 변수명은 Lower Camel 사용 
* 함수명도 Lower Camel 사용
* Extension 이름 ==> UIViewController+Extension
* TableView Extension 경우 ==> 따로 분리하여 기능별로
* 남의 스토리보드 절대 건들지 말기
* Optional 변수 (!) 사용 지양하기 ==> guard let 적극 활용





### 라이브러리

- 'Alamofire', '~> 4.8.2'
- 'KingFisher',`~> 5.4.0'
- 'CHIPageControl', `~> 0.1.7'
- 'XLPagerTabStrip', '~> 9.0'
- 'BEMCheckBox'



### 실행화면



**시작 화면**

<img src="./images/login.png" height="400px"/>







### 어려운 것 해결한 것

2. TableView 안 CollectionView 그리기
4. CollectionView 레이아웃 잡기 (DelegateFlowLayout 안잡힘)

🔵 Interface Builder AutoLayout 옵션에서 `None`으로 지정하면 코드로 지정한대로 설정

```swift
extension ViewController: UICollectionViewDelegateFlowLayout {
  
}
```



3. Animationable Property가 존재

1️⃣ frame

2️⃣ bounds

3️⃣ center

4️⃣ transform

5️⃣ alpha

6️⃣ backgroundColor

7️⃣ contentStretch



4. ScrollView Delegate활용 PageControl ( ✅ `CHIPageControl` 사용 )

```swift
func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
  let page = Int(targetContentOffset.pointee.x / self.view.frame.width)
  pageControl.set(progress: page, animated: true)
}
```



5. UIView Blur 처리

```swift
var backgroundEffectView: UIVisualEffectView!		// Visual Effect을 넣을 수 있는 View

func setBlurView() {
  let blurEffect = UIBlurEffect(style: dark) 		// Blur Effect 넣을 수 있는 것 생성
  backgroundEffectView.effect = blurEffect			// UIVisualEffectView에 Blur효과 적용
}
```



6. 전체 레이아웃이 제대로 적용 안되는 문제 iPhone 11 Pro Max 에서 작업 후 ==> iPhone 11 Pro에 적용할 경우 레이아웃이 Pro Max로 적용되어 Button의 Radius가 적용이 안됨

```swift
// Layout 관련 메소드 공부들 더 필요
// View의 SubView들의 레이아웃 관련해서 다시 잡아줄 필요가 있을 경우
// 이 함수에서 View들의 Layout을 다시 리셋시켜주면서 잡아준다.
// iPhone11 Pro Max를 기준으로 잡혀있던 것을 iPhone 11 Pro을 기준으로 다시 잡을 수 있게 해준다.
override func viewDidLayoutSubviews() {
  super.viewDidLayoutSubviews()
  initColorButtons()
}
```



7. StackView 이용 Animation 적용 AutoLayout 잡아주기

🔵 필터를 적용했을 때만 선택하는 메뉴에서 StackView을 활용 오토레이아웃을 잡아주었다. `isHidden` 옵션 활용

```

```





### 참가자

* 오태진 - iOS
* 윤동민 - iOS