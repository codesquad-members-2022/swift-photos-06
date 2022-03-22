# swift-photos-06

## [수정 이력]
| 날짜       | 번호   | 내용                                    | 비고                             |
| ---------- | :----- | --------------------------------------- | -------------------------------- |
| 2022.03.23 | STEP1 | Collection View 구현하기                  |                                  |

<details>
<summary> STEP1 : 프로젝트 설정 </summary>

## [작업 목록]

- [X] Git 환경 세팅 
- [X] 스토리보드 ViewController에 CollectionView를 추가하고 Safe 영역에 가득 채우도록 frame을 설정한다.
- [X] CollectionView Cell 크기를 80 x 80 로 지정한다.
- [X] UICollectionViewDataSource 프로토콜을 채택하고 40개 cell을 랜덤한 색상으로 채우도록 구현한다.


## [작업 기록]
- 짝프로그래밍 진행방식 

  → 기능마다 테스트 함수 작성과 기능 구현 을 번갈아 가면서 진행한다. 
  
  → Git PR 제목과 브랜치명을 일치한다. 

- Collection View 

  → UICollectionView
    - 여러 데이터를 관리하고 설정이 가능한 레이아웃을 사용하여 사용자에게 보여줄수 있게 하는 객체이다.  
    - `UIScrollView` 를 상속받고 있고, 이는 `UITableView`, `UITextView` 등 의 상위 클래스이기도 하다. 
    > `UIScrollView` 는 스크롤되는 뷰들을 담고 있는 `Content Layout` 과 화면에 보여지는 `Frame Layout` 으로 나누어 지고 이들을 스크롤과 줌을 할 수 있게 해주는 View 이고 이를 활용하여 스크롤이 가능해지는 Collection View 를 만들수 있게된다. 
    - 컬렉션뷰는 테이블 뷰와 같이 `UICollectionViewCell` 를 사용하여 데이터를 화면에 표현한다. 

  → Layout 
    - 셀들이 나열되는 방식을 결정하는 레이아웃으로서 2 가지가 존재한다. 
    - UICollectionViewLayout = 추상클래스로서, prepare(), CollectionViewContentSize, layoutAttributesForElements(), layoutAttributesForItem() 의 스켈리톤 함수/프로퍼티를 가지고 있다.
    
    - UICollectionVeiwFlowLayout = UICollectionViewLayout 의 서브 클래스 로서 위의 함수들과 프로퍼티가 구현이 되어있어서 cell 들이 그리드 혹은 다른 라인기반(lined-based) 레이아웃을 구현하는 데 사용된다. 클래스를 그대로 사용하거나 동적으로 설정할수있는 델리게이트 객체와 함께 사용가능하다. 
     
    - FlowLayout 구성 단계 
    
        1.0 : FlowLayout 인스턴스 생성우, 컬렉션뷰의 레이아웃 객체로 지정. 
        
        2.0 : Cell 의 높이, 넓이 설정(Default = 0,0) 
        
        3.0 : Cell 의 간격 조정, (minimumLineSpacing & minimumInteritemSpacing) 
        
        4.0 : 섹션 Header / Footer 의 필요 유무에 따라 크기 지정
        
        5.0 : 레이아웃 스크롤 방향 설정(Default = vertical)
         
  → UICollectionViewCell
    - `Collection View` 의 보여지는 부분안에 있을때 있는 하나의 데이터
    - 보통 Cell 의 인스턴스를 직접 생성하지않고 `cell registration` 에 등록하는 방법으로 쓰인다. 
    - 셀의 인스턴스를 생성하고 싶다면 `Collection View` 오브젝트의 `dequeueConfiguredReusableCell(using:for:item:)` 를 사용할수있다. 

  → UICollectionViewDelegate
    - 컬렉션뷰 간의 상호작용 관리 
    
  → UICollectionViewDataSource
  
    - 컬렉션뷰에 표시할 콘텐츠 정보 관리 및 제공
    
    ```swift 
    // 섹션에 표시 할 셀 갯수를 묻는 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    
    // 콜렉션 뷰의 특정 인덱스에서 표시할 셀을 요청하는 메서드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    ```
    
  → UICollectionViewDelegateFlowLayout
  
    - 셀의 크기나 레이아웃에 관련된 델리게이트로 구성됨 
        
    ```swift 
    //지정된 셀의 크기를 반환하는 메서드
    optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize 
    
    //지정된 섹션의 여백을 반환하는 메서드
    optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    
    ```
    
[참조1](https://lsh424.tistory.com/52)

[참조2](https://developer.apple.com/documentation/uikit/uicollectionview)

- Class Diagram

![image](https://user-images.githubusercontent.com/36659877/159521353-7e6ee5dc-4f2e-4a18-85b4-d22c0773eb43.png)


</details>
