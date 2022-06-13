# Jekyll 사용 설명서

## 1. 기본 작동 원리
Jekyll은 저장소 내의 Markdown(`.md`) 문서 파일을 HTML로 빌드해주는 소프트웨어입니다. 동시에 빌드 결과물을 내장 서버 엔진을 사용하여 외부에 공개하는 마이크로블로그 엔진이기도 합니다.

이 레포지토리의 모든 파일은 Markdown에서 HTML로 변환하는 과정에서 어떤 처리가 필요한지 구체적으로 정의한 것에 지나지 않습니다.

## 1.1. 빌드 과정
Jekyll의 빌드 과정은 단순합니다.

1. (진입점) `.md` 파일 로드, YAML 헤더 확인
   * YAML 헤더는 `.md` 파일 상단의 `---`로 시작하고 `---`로 끝나는 부분을 의미합니다.
2. `layout` 설정을 읽어 `_layouts`에서 해당하는 레이아웃 정의를 로드합니다.
3. 로드된 레이아웃에 Markdown 파일의 콘텐츠를 삽입합니다. 이 과정에서 컴포넌트를 불러옵니다.
4. 필요하다면 include 파일을 로드하여 레이아웃 코드에 삽입합니다.

* Markdown만 HTML로 빌드된다는 듯 설명했지만, YAML 헤더가 있는 모든 코드가 Jekyll의 변환 대상입니다.
   * 예시: [`index.html`](../index.html), [`inversion.scss`](../_sass/inversion.scss) 파일 참조

## 2. 폴더 구조
이 저장소의 폴더는 두 가지 종류의 이름을 갖고 있습니다.  
1. `_`가 이름 앞에 붙은 폴더 (`_posts`)
2. 일반 폴더

Jekyll은 페이지를 빌드하거나 서버로 동작할 때 이름 앞에 `_`가 붙은 폴더나 파일을 숨깁니다. (빌드에서 제외합니다.) 따라서 빌드 과정 중 필요한 설정 값이나 원본 Markdown 파일을 보관하는데 이러한 유형의 폴더를 자주 사용합니다.
* `_data` : 추가 데이터에 대한 데이터베이스
* `_includes` : DOM 컴포넌트 요소. 이 컴포넌트를 조합하여 레이아웃이 완성됩니다.
* `_layouts` : 이 웹사이트가 가질 여러가지 레이아웃 정의입니다.
* `_posts` : 실제 포스트가 저장됩니다. 하지만 이 사이트는 블로그로 운영하기 위해 만든 것이 아니므로 "새 소식" 파트를 위해 준비되었습니다.
* `_sass` : SASS 스타일 정의 파일입니다.

`_`가 붙지 않은 폴더는 그대로 외부에 노출됩니다.
* `assets` : 웹 사이트 에셋을 저장합니다. SASS 코드의 CSS 컴파일 결과 파일이 이 폴더에 저장됩니다. 즉 `_sass` 코드가 `assets` 폴더로 공개됩니다.
* `pages` : HTML로 변환할, _포스트가 아닌_ Markdown 문서를 저장합니다. (이 폴더 아래의 Markdown 문서들은 모두 `permalink` 속성을 갖고 있으므로 빈 `pages` 폴더가 빌드 결과로 제공되지는 않습니다.)

### 2.1. 그 외 파일들
* `_config.yml` : Jekyll의 설정 파일입니다. 사이트 설정 값들을 지정합니다.
* `.gitignore`
* `404.html` : 404 페이지입니다. 실제로 404를 화면에 표시해야할 때 사용됩니다.
* `CNAME` : Github Pages 서비스 사용 시 도메인 포워딩을 위해 사용됩니다.
* `Gemfile` `Gemfile.lock` : Jekyll과 Jekyll의 의존성 모듈, 확장 프로그램들을 로드하기 위한 RubyGem 파일입니다.
* `index.html`
* `README.md`

## 3. YAML 헤더
YAML 헤더는 Jekyll이 문서를 읽어들이면서 어떻게 빌드를 처리해야하는지 간단한 설정값을 지정합니다.

```md
---
title: 접수
class: hideable
hide: true
hidedesc: "아직 접수가 시작되지 않았습니다."
layout: default
pagetype: submission
permalink: /submission
---
```

* `title` : 문서의 제목
* `layout` : 문서의 레이아웃
* `permalink` : 문서의 고유 주소. `permalink: /update`로 설정되어있다면 `https://url.url/update` 식으로 접근 가능
* `class` : (비표준) 문서의 클래스. 지정값 없으면 지워도 됨
* `hide` : (비표준) hideable 문서에서 비공개 여부 설정
* `hidedesc` : (비표준) hideable 문서에서 문서 비공개 시 표시할 문구 설정
* `pagetype` : (비표준) 
* `navselect` : (비표준) 사이트의 상단 네비게이션 바에게 현재 위치를 제공하는 값

### 3.1. 비표준 Jekyll YAML 정의
이 사이트의 목적을 달성하기 위해 여러가지 자체 속성과 코드를 사용합니다.  

#### 3.1.1. `hideable`과 `hide`속성
hideable 속성은 Jekyll에 없는 글 비공개 기능입니다.

YAML헤더에 `class: hideable`을 추가하면 비공개가 가능한 레이아웃으로 빌드됩니다. `hideable` 클래스의 문서는 `hide: true` 헤더를 추가하여 문서를 비공개할 수 있습니다. 비공개 해제는 `hide: false`로 변경하거나 `hide` 속성을 제거하여 수행할 수 있습니다.

`hideable` 레이아웃에서는 `hidedesc` 속성도 가질 수 있습니다. `hidedesc` 속성은 비공개 게시물에 접근했을 때 화면에 표시할 말을 설정할 수 있습니다. 만약 `hidedesc` 속성이 없다면 `_config.yml` 파일의 설정값으로 표시됩니다.
* `_config.yml`의 `default-hidedesc` 속성이 기본값으로 사용됩니다.

## 4. 그 외 DOM 컴포넌트 간 상호작용
### 4.1. 상단 네비게이션 바
상단 네비게이션 바는 `/_includes/header.html` 에 정의되어있습니다.  
네비게이션 바는 각 페이지와 포스트 YAML 헤더의 `navselect` 속성을 기준으로 작동합니다.  

만약 `navselect` 속성이 `header.html`에 기록된 값이라면 헤당 탭에 `now` 클래스가 추가됩니다.  
자세한 내용은 헤더 컴포넌트 정의를 참조하세요.  

### 4.2. 게시판 카테고리 페이지
포스트는 카테고리 관계 없이 `_posts` 페이지 하위에 작성됩니다.  

카테고리 페이지는 YAML 헤더에 `pagetype: categories`를 추가하여 생성합니다.  
아래는 카테고리 페이지(`/pages/categories.md`) 예시입니다.
```md
---
title: 게시판 기능
class: hideable
hide: false
hidedesc: "게시판 기능"
layout: default
pagetype: categories
navselect: __NONE__
permalink: /categories
target_tags: [jekyll, test]
---
```
* `pagetype: categories`는 이 페이지가 게시판 카테고리 페이지로 표시되게 합니다.
* 만약 YAML 헤더에 `target_tags`가 있다면 `target_tags`에 들어 있는 태그만 표시합니다.  

아래는 지킬 기본 포스트인 `"Welcome to Jekyll!"`의 시작 부분입니다.  
```md
---
layout: post
title:  "Welcome to Jekyll!"
date:   2022-06-02 22:02:13 +0900
class: hideable
hide: false
categories: jekyll update
navselect: updates
---
You’ll find this post in your `_posts` directory. Go ahead and edit it and re-build the site to see your changes. You can rebuild the site in many different ways, but the most common way is to run `jekyll serve`, which launches a web server and auto-regenerates your site when a file is updated.
```

위와 같이 작성되면 `jekyll` 태그와 `update` 태그가 공개 설정된 카테고리 페이지에 위 포스트가 표시됩니다.  


**상세 사용 예**  
만약 공지와 새 소식 게시판을 나누고자 한다면 아래와 같이 작성할 수 있습니다.  

* `/pages/notifications.md`
```md
---
title: 공지
layout: default
pagetype: categories
navselect: notifications
permalink: /notifications
target_tags: [notifications]
---
```

* `/pages/updates.md`
```md
---
title: 공지
layout: default
pagetype: categories
navselect: updates
permalink: /updates
target_tags: [updates]
---
```

위와 같이 작성한다면 `/updates` 는 `updates` 태그가 붙은 포스트만 가져오고, `/notifications` 는 `notifications` 태그가 붙은 포스트만 가져옵니다.  
만약 포스트의 태그가 `updates`, `notifications` 둘 다 붙어있다면 두 페이지 모두에서 작동합니다.  
