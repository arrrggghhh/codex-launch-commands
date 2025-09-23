# Codex Launcher Shortcuts

이 저장소는 Codex CLI를 빠르게 실행하기 위한 단축 명령어들을 제공합니다.
설치 스크립트를 통해 `~/.local/bin`에 심볼릭 링크를 생성하며, 각 단축 명령어는 `codex` CLI를 지정된 모델과 reasoning effort 기본값으로 실행합니다.

## 요구 사항
- `codex` 명령어가 설치되어 있고 `PATH`에 있어야 합니다.
- Bash, `ln`, `readlink` 등 기본 유틸리티가 있어야 합니다.
- 권장 OS: Linux 또는 macOS (macOS에서도 스크립트가 `readlink -f` 미지원 시 `readlink`로 자동 대체)

## 설치 스크립트 사용법
1) 저장소 디렉터리에서 다음 스크립트를 실행합니다.

```bash
./scripts/install-codex-shortcuts.sh
```

2) 스크립트는 다음 위치에 심볼릭 링크를 만듭니다.
- `~/.local/bin`

3) `~/.local/bin`이 `PATH`에 없다면 다음을 쉘 설정 파일에 추가합니다.

```bash
export PATH="$HOME/.local/bin:$PATH"
```

4) 정상 설치 확인

```bash
which cdxm
cdxm --help  # codex의 기본 도움말이 출력되면 정상
```

## 설치되는 명령어
모든 명령어는 뒤에 오는 인자와 옵션을 그대로 `codex`에 전달합니다.
괄호 안은 기본 지정되는 모델(`-m`)과 reasoning effort(`-c model_reasoning_effort=...`)입니다.

- `cdxmm`  (gpt-5, minimal)
- `cdxl`   (gpt-5, low)
- `cdxm`   (gpt-5, medium)
- `cdxh`   (gpt-5, high)
- `cdxxl`  (gpt-5-codex, low)
- `cdxxm`  (gpt-5-codex, medium)
- `cdxxh`  (gpt-5-codex, high)

## 사용 예시
- 도움말 보기(모든 명령 동일):

```bash
cdxm --help
```

- 추가 옵션 전달(예: 로그 레벨 변경, 설정 키 추가 등):

```bash
cdxh -c some_key=some_value --verbose
```

- 모델/리즌잉 기본값은 각 단축 명령어가 지정합니다. 동일 키를 추가로 전달하는 경우 충돌 시 최종 우선순위는 `codex`의 규칙을 따릅니다.

## 문제 해결
- `command not found: cdxm` 등 오류가 발생하면 `~/.local/bin`이 `PATH`에 포함되어 있는지 확인하세요.
- `codex`가 설치되어 있지 않다면 먼저 `codex` CLI를 설치하고 사용하세요.
- 재설치/업데이트 시에는 스크립트를 다시 실행하면 심볼릭 링크가 갱신됩니다.

