# Prompt Enhancer - Full Implementation Detail

> Loaded on-demand. Header: [../SKILL.md](../SKILL.md)

## Analysis Patterns by Stack

### Flutter Projects

**Detect**: pubspec.yaml, lib/ directory

**Key context**: State management (Riverpod, Bloc, Provider), Architecture (Clean, MVVM), Navigation (go_router, auto_route), Network (Dio, http), Storage (Hive, SharedPreferences)

**Enhanced requirements include:**
```markdown
### Presentation Layer
- 화면: lib/presentation/[feature]/[screen]_screen.dart
- 상태: [StateNotifier/Bloc/Controller]

### Domain Layer
- Entity / UseCase / Repository Interface

### Data Layer
- Model (fromJson/toJson) / Repository Impl / DataSource

### Navigation
- Route path / Navigation method

### 성공 기준
✅ [State management]로 상태 관리
✅ 기존 위젯 스타일 일관성
✅ API 에러 처리 + 로딩 상태
✅ Widget test 작성
```

### Next.js/React Projects

**Detect**: package.json with "next" or "react"

**Key context**: Next.js version (App/Pages Router), State (Zustand, Redux, Context), Styling (Tailwind, CSS Modules), API approach, TypeScript

**Enhanced requirements include:**
```markdown
### UI Components
- 컴포넌트: [path]/[Name].tsx + Props interface + [Tailwind/CSS modules]

### State Management
- Store structure + Action naming convention

### API Layer
- Endpoint + Method + Response type (TypeScript)

### Routing
- [app/[route] or pages/[route]] + Dynamic segments

### 성공 기준
✅ TypeScript 타입 안정성
✅ 반응형 (모바일/데스크톱)
✅ SEO 최적화
✅ Unit + Integration test
```

### Python (Django/FastAPI) Projects

**Detect**: requirements.txt, manage.py, main.py

**Key context**: Framework (Django, FastAPI, Flask), ORM (SQLAlchemy, Django ORM), Auth, API docs (OpenAPI)

**Enhanced requirements include:**
```markdown
### Models/Schema
- Model fields, types, relationships

### Views/Endpoints
- Route + Method + Request/Response schema (Pydantic)

### Business Logic
- Service layer + Validation

### 성공 기준
✅ API documentation 자동
✅ Request validation + Error handling
✅ Unit + Integration test
✅ [Authentication] 적용
```

## Example Enhancement

**User input**: `"로그인 기능 구현해줘"`

**Skill output**:
```markdown
# 로그인 기능 구현 요구사항

## 📋 프로젝트 컨텍스트
- Framework: Flutter 3.16.0 with null safety
- Architecture: Clean Architecture
- State: Riverpod (StateNotifier)
- Network: Dio 5.3.0
- Storage: flutter_secure_storage

## 🎯 구현 범위
1. 이메일/비밀번호 로그인 폼
2. JWT 토큰 기반 인증
3. 로그인 성공 시 홈 화면 이동
4. 에러 처리 및 사용자 피드백

### 파일 구조
lib/
├── presentation/auth/ (login_screen, notifier, state)
├── domain/ (user entity, login_usecase, auth_repository)
└── data/ (user_model, auth_repository_impl, auth_datasource)

## 📝 상세 요구사항
1. Presentation: ConsumerStatefulWidget, Email/Password validation
2. State: StateNotifier<LoginState>, login(email, pw)
3. Domain: Freezed entity, Either<Failure, User>
4. Data: POST /api/auth/login, Dio, TokenStorage
5. Navigation: /login route, auth guard

## ✅ 성공 기준
- [ ] 이메일/비밀번호 입력 → API 호출
- [ ] 성공 시 토큰 저장 + 홈 이동
- [ ] 실패 시 에러 SnackBar
- [ ] 로딩 중 버튼 비활성화
- [ ] Widget/Repository/UseCase 테스트

## 🔍 확인 사항
- API 엔드포인트 주소?
- 토큰 자동 갱신?
- 소셜 로그인?
- 비밀번호 찾기?

---
이 요구사항으로 진행할까요?
```

## Tips for Effective Enhancement

### Always Ask for Clarification
```
프로젝트 파일을 업로드해주시면 더 정확한 요구사항을 만들 수 있습니다.
또는: 사용 프레임워크, 상태 관리 라이브러리, 프로젝트 구조
```

### Include Visual Examples
```
기존 ProfileScreen과 유사한 레이아웃
- AppBar 스타일 동일
- TextFormField 디자인 재사용
- PrimaryButton 컴포넌트 사용
```

### Highlight Dependencies
```
## 🔗 연관 기능
- UserRepository: 사용자 정보 조회 재사용
- TokenStorage: 기존 토큰 저장 로직 활용
- ErrorHandler: 공통 에러 처리 적용
```

## Reference Files
- **Enhancement patterns**: references/enhancement-patterns.md
- **Framework guides**: references/framework-guides.md
