# SOLACE / Astra reference package

Date frozen: 2026-09-04
Purpose: immutable benchmark inputs for the Astra + Blender LAB.

## Policy

The files in this directory are reference inputs. Generated outputs, screenshots, corrected renders and benchmark runs must go elsewhere (future `benchmarks/solace/runs/...`). Do not overwrite these references.

The GitHub media files are **optimized reference copies** so they remain practical to version and inspect in the repository. The original conversation uploads remain the provenance source. Original and repository-copy SHA-256 hashes are recorded below so the relationship is explicit.

## Inventory

| Repo file | Role | Original upload | Original SHA-256 | Repo-copy SHA-256 |
|---|---|---|---|---|
| `00_thomas_astra_palacio_post.jpg` | Thomas/Astra Palacio workflow screenshot | `6ae8c7df-b0a3-4516-8293-16d7c418e8d7.png` | `261781d143e5585f7383b36cb2447c6ea868ae5051a05cc66a7be0d0cf7221df` | `8dfef9d217066987e810e28e6779ebfe24f9c19e568e7a41119cf0434363e5ac` |
| `01_solace_floorplan.jpg` | SOLACE concept floorplan | `HRUOGWHaMAATXEa.jpg` | `39995a08c5d15345e672758af8eeb4e7ec1dfe89fc90668a63b38b3e055440f3` | `9662ed7dbce2309165c5673e6dc445cfb0588625e9e8257ab11f53535c1fdfb4` |
| `02_solace_kitchen.jpg` | kitchen/dining visual reference | `264e64ee-944e-49bf-9612-5bd21965ac84.png` | `547b6bcc8a1b10a763fe1855ac4552c76302cb0b81763a4501149f745a953d8e` | `eb72cdc1a26f02e86d376a2e92a4793cc3023e3ba35688d6a00e1d5968eab7bb` |
| `03_solace_pool_exterior.jpg` | pool/garden exterior visual reference | `8891f953-9ddc-4fcc-976b-eb00489e14d8.png` | `58ef3a32128d97d2dd88d91bd47c33fba20df2c183f3098ae844921f4434bf05` | `2d1abc5372856b6674761253e066cb012d1006faa01b44b5df02f63f1cdc94d7` |
| `04_solace_living.jpg` | living/library visual reference | `c6f6bf7c-30a8-4149-8db9-c213727853b3.png` | `3999d4883f94dc838a31ba7c7e10f44c43ffaa9ae5a6c9d28006edad3adf4ffe` | `816ae3eadc6ddea8891cd48b5b15e9638c9966ac510c4638f016366b95d35ed5` |
| `05_solace_unreal_engine5_board.jpg` | UE5 comparison board | `85e79d8e-76b2-4f63-b19b-354de2033ad8.png` | `88063ef7e4595b8afeff7e6fbe294457581021fffb98ad2db6549ccdf2aa0e0c` | `db0da24ce58b5e6617afda599260ff94d4ead2d1a39a97a4e18442dce202102e` |
| `06_solace_blender_cycles_board.jpg` | Blender/Cycles comparison board | `8c7ed6cb-744f-4dd6-a8c3-0bc5d10cfcb4.png` | `428bf47c73e5298efe6360bcaf5f94661dcb0494db0aba8ba9f62199c4d279ba` | `51cf64920c149db2f73eca756f9c2d6e4059a066fef0a22dcb6840cf3af263fe` |
| `07_blender_astra_inmobiliaria_process_reference.mp4` | process/iteration video | `BLENDER ASTRA INMOBILIARIA 2.mp4` | `70623eaa99178a94330a963d87571f2769bd3bd647ff2527e6726ae0717d5a24` | `ef31a29e0a211e3c8eee6de9c3f0ff13f1eb9d95827c1366c16d5e59bbaeb7a0` |
| `08_solace_walkthrough_reference.mp4` | final walkthrough reference | `VIDEO REFERENCIA BLENDER ASTRA INMOBILIARIA.mp4` | `591952bc3c20acfbe9e412ffe414103dfd29bd5e67203c7fdcbb64167eb783cf` | `718abc6bd90b1688f49fb65e522d086e7ade9ed9a99377f4ff4323e773e39779` |

## Optimization note

Images are visually faithful JPEG reference copies sized for GitHub review. Videos are H.264 visual-reference transcodes without audio, reduced in resolution/bitrate for repository practicality. They are not intended as archival masters or final-quality deliverables.

## Benchmark interpretation

- The floorplan is concept material and explicitly not a construction survey.
- The Blender and UE5 boards show the intended scene correspondence across renderers.
- Video `07` is primarily evidence of iterative scene creation and visual checking.
- Video `08` is the cinematic target; the first living -> dining -> kitchen sequence is the first POC slice.

See:

- `docs/ASTRA-SOLACE-BENCHMARK.md`
- `docs/ROADMAP-HOY-ASTRA-SOLACE.md`
- `docs/ASTRA-LAB-SETUP.md`
